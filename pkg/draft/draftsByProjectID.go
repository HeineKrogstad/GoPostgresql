package draft

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"

	"context"
)

func GetDraftsByProjectID(ctx context.Context, projectID int) ([]models.Draft, error) {
	rows, err := database.Conn.Query(ctx, "SELECT * FROM draft WHERE id_project=$1", projectID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var drafts []models.Draft

	for rows.Next() {
		var d models.Draft
		err := rows.Scan(
			&d.ID,
			&d.NodeID,
			&d.ProjectID,
			&d.UserProfileID,
			&d.JContent,
			&d.HContent,
			&d.Rubric,
			&d.DtCreate,
		)
		if err != nil {
			return nil, err
		}
		drafts = append(drafts, d)
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	return drafts, nil
}
