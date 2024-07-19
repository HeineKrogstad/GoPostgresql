package models

import (
	"encoding/json"
	"time"
)

type Draft struct {
	ID            string          `json:"id_draft"`
	NodeID        int             `json:"id_node"`
	ProjectID     int             `json:"id_project"`
	UserProfileID *int            `json:"id_user_profile"`
	JContent      json.RawMessage `json:"jcontent"`
	HContent      *string         `json:"hcontent"`
	Rubric        string          `json:"rubric"`
	DtCreate      time.Time       `json:"dt_create"`
}
