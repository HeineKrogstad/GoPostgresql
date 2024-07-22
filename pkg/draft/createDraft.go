package draft

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
	"time"

	"github.com/google/uuid"
)

func CreateDraft(node models.Node, draft models.Draft, attachment models.Attachment) error {
	ctx := context.Background()

	tx, err := database.Conn.Begin(ctx)
	if err != nil {
		return err
	}
	defer tx.Rollback(ctx)

	// Insert into node
	var nodeID int
	err = tx.QueryRow(ctx,
		`INSERT INTO "node" (id_tp_node, id_parent_node, name, dt_create)
		 VALUES ($1, $2, $3, CURRENT_TIMESTAMP)
		 RETURNING id_node`,
		node.TpNodeID, node.ParentNodeID, node.Name).Scan(&nodeID)
	if err != nil {
		return err
	}

	// Prepare draft data
	draft.ID = uuid.New()
	draft.NodeID = nodeID
	draft.DtCreate = time.Now()

	// Insert into draft
	var draftID uuid.UUID
	err = tx.QueryRow(ctx,
		`INSERT INTO "draft" (id_draft, id_node, id_project, id_user_profile, jcontent, hcontent, rubric, dt_create)
		 VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
		 RETURNING id_draft`,
		draft.ID, draft.NodeID, draft.ProjectID, draft.UserProfileID, draft.JContent, draft.HContent, draft.Rubric, draft.DtCreate).Scan(&draftID)
	if err != nil {
		return err
	}

	// Insert into attachment
	_, err = tx.Exec(ctx,
		`INSERT INTO "attachment" (id_draft, id_tp_attachment, amount)
		 VALUES ($1, $2, $3)`,
		draftID, attachment.IDTpAttachment, attachment.Amount)
	if err != nil {
		return err
	}

	// Commit the transaction
	if err = tx.Commit(ctx); err != nil {
		return err
	}

	return nil
}
