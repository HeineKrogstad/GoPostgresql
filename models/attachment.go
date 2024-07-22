package models

import (
	"github.com/google/uuid"
)

type Attachment struct {
	IDAttachment   int       `json:"id_attachment"`
	IDDraft        uuid.UUID `json:"id_draft"`
	IDTpAttachment int       `json:"id_tp_attachment"`
	Amount         int       `json:"amount,omitempty"`
}
