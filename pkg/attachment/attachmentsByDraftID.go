package attachment

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"

	"github.com/google/uuid"
)

func GetAttachmentsByDraftID(ctx context.Context, draftID uuid.UUID) ([]models.Attachment, error) {
	query := `SELECT id_attachment, id_draft, id_tp_attachment, amount FROM attachment WHERE id_draft = $1`
	rows, err := database.Conn.Query(ctx, query, draftID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var attachments []models.Attachment
	for rows.Next() {
		var attachment models.Attachment
		err := rows.Scan(
			&attachment.IDAttachment,
			&attachment.IDDraft,
			&attachment.IDTpAttachment,
			&attachment.Amount,
		)
		if err != nil {
			return nil, err
		}
		attachments = append(attachments, attachment)
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	return attachments, nil
}
