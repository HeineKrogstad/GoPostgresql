package models

import (
	"encoding/json"
	"time"
)

type Project struct {
	ID                int             `json:"id_project"`
	CategoryID        int             `json:"id_category"`
	ParentProjectID   *int            `json:"id_parent_project"`
	Title             string          `json:"title"`
	Keywords          string          `json:"keywords"`
	Abbreviation      string          `json:"abbreviation"`
	Status            *int            `json:"status"`
	DescFull          string          `json:"desc_full"`
	DescShort         string          `json:"desc_short"`
	Category          string          `json:"category"`
	HrefAvatar        string          `json:"href_avatar"`
	IsFavorites       *bool           `json:"is_favorites"`
	Owner             *bool           `json:"owner"`
	NameRev           string          `json:"name_rev"`
	DtStart           time.Time       `json:"dt_start"`
	DtEnd             time.Time       `json:"dt_end"`
	LastChanged       time.Time       `json:"last_changed"`
	LastChangedAuthor string          `json:"last_changed_author"`
	Actions           string          `json:"actions"`
	Tag               json.RawMessage `json:"tag"`
	TypeParent        *int            `json:"typeParent"`
	OnYarmarka        *bool           `json:"onYarmarka"`
	Goal              string          `json:"goal"`
	Params            json.RawMessage `json:"params"`
}
