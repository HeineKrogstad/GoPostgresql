package draft

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
)

func GetDraftByNodeID(ctx context.Context, nodeId int) (*models.Draft, error) {
	query := `
		SELECT 
			id_draft,
			id_node,
			id_project,
			id_user_profile,
			jcontent,
			hcontent,
			rubric,
			dt_create
		FROM draft
		WHERE id_node = $1
	`

	row := database.Conn.QueryRow(ctx, query, nodeId)

	var draft models.Draft
	err := row.Scan(
		&draft.ID,
		&draft.NodeID,
		&draft.ProjectID,
		&draft.UserProfileID,
		&draft.JContent,
		&draft.HContent,
		&draft.Rubric,
		&draft.DtCreate,
	)
	if err != nil {
		return nil, err
	}

	return &draft, nil
}
