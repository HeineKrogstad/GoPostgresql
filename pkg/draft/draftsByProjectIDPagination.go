package draft

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
	"fmt"
)

func GetDraftsByProjectIDPagination(ctx context.Context, projectID, limit, offset int) ([]models.Draft, error) {
	query := fmt.Sprintf("SELECT * FROM draft WHERE id_project=$1 LIMIT %d OFFSET %d", limit, offset)
	rows, err := database.Conn.Query(ctx, query, projectID)
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
