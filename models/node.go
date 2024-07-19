package models

import "time"

type Node struct {
	ID           int        `json:"id_node"`
	TpNodeID     int        `json:"id_tp_node"`
	ParentNodeID *int       `json:"id_parent_node,omitempty"` // Может быть NULL
	Name         string     `json:"name"`
	DtCreate     *time.Time `json:"dt_create"`
}
