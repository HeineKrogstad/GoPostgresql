package node

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
)

// Функция для получения всех узлов
func GetAllNodes(ctx context.Context) ([]models.Node, error) {
	query := "SELECT * FROM node"
	rows, err := database.Conn.Query(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var nodes []models.Node

	for rows.Next() {
		var node models.Node
		err := rows.Scan(
			&node.ID,
			&node.TpNodeID,
			&node.ParentNodeID,
			&node.Name,
			&node.DtCreate,
		)
		if err != nil {
			return nil, err
		}
		nodes = append(nodes, node)
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	return nodes, nil
}
