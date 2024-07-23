package draft

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
	"log"
	"time"

	"github.com/google/uuid"
)

func CreateDraft(node models.Node, draft models.Draft, attachments []models.Attachment) (models.Draft, models.Node, []models.Attachment, error) {
	ctx := context.Background()

	tx, err := database.Conn.Begin(ctx)
	if err != nil {
		return models.Draft{}, models.Node{}, nil, err
	}
	defer tx.Rollback(ctx)

	var nodeID int
	err = tx.QueryRow(ctx,
		`INSERT INTO "node" (id_tp_node, id_parent_node, name, dt_create)
		 VALUES ($1, $2, $3, CURRENT_TIMESTAMP)
		 RETURNING id_node`,
		node.TpNodeID, node.ParentNodeID, node.Name).Scan(&nodeID)
	if err != nil {
		return models.Draft{}, models.Node{}, nil, err
	}

	draft.ID = uuid.New()
	draft.NodeID = nodeID
	draft.DtCreate = time.Now()

	var draftID uuid.UUID
	err = tx.QueryRow(ctx,
		`INSERT INTO "draft" (id_draft, id_node, id_project, id_user_profile, jcontent, hcontent, rubric, dt_create)
		 VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
		 RETURNING id_draft`,
		draft.ID, draft.NodeID, draft.ProjectID, draft.UserProfileID, draft.JContent, draft.HContent, draft.Rubric, draft.DtCreate).Scan(&draftID)
	if err != nil {
		return models.Draft{}, models.Node{}, nil, err
	}

	for i := range attachments {
		attachments[i].IDDraft = draftID
		err = tx.QueryRow(ctx,
			`INSERT INTO "attachment" (id_draft, id_tp_attachment, amount)
			 VALUES ($1, $2, $3)
			 RETURNING id_attachment`,
			attachments[i].IDDraft, attachments[i].IDTpAttachment, attachments[i].Amount).Scan(&attachments[i].IDAttachment)
		if err != nil {
			log.Println("Error inserting attachment:", err)
			return models.Draft{}, models.Node{}, nil, err
		}
	}

	if err = tx.Commit(ctx); err != nil {
		return models.Draft{}, models.Node{}, nil, err
	}

	node.ID = nodeID

	return draft, node, attachments, nil
}
