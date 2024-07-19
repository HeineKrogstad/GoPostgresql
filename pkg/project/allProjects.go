package project

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
)

func GetProjects() ([]models.Project, error) {
	rows, err := database.Conn.Query(context.Background(), "SELECT * FROM project")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var projects []models.Project

	for rows.Next() {
		var p models.Project
		err := rows.Scan(
			&p.ID,
			&p.CategoryID,
			&p.ParentProjectID,
			&p.Title,
			&p.Keywords,
			&p.Abbreviation,
			&p.Status,
			&p.DescFull,
			&p.DescShort,
			&p.Category,
			&p.HrefAvatar,
			&p.IsFavorites,
			&p.Owner,
			&p.NameRev,
			&p.DtStart,
			&p.DtEnd,
			&p.LastChanged,
			&p.LastChangedAuthor,
			&p.Actions,
			&p.Tag,
			&p.TypeParent,
			&p.OnYarmarka,
			&p.Goal,
			&p.Params,
		)
		if err != nil {
			return nil, err
		}
		projects = append(projects, p)
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	return projects, nil
}
