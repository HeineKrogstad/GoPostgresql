package draft

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
)

func GetDraftsByProjectAndRubric(ctx context.Context, projectID int, rubric string) ([]models.Draft, error) {
	query := `SELECT id_draft, id_node, id_project, id_user_profile, jcontent, hcontent, rubric, dt_create FROM draft WHERE id_project = $1 AND rubric = $2`
	rows, err := database.Conn.Query(ctx, query, projectID, rubric)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var drafts []models.Draft
	for rows.Next() {
		var draft models.Draft
		err := rows.Scan(
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

		drafts = append(drafts, draft)
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	return drafts, nil
}
