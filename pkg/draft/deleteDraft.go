package draft

import (
	"GoPostgresql/pkg/database"
	"context"

	"github.com/google/uuid"
)

func DeleteDraftByID(ctx context.Context, draftID uuid.UUID) error {
	_, err := database.Conn.Exec(ctx, `DELETE FROM "draft" WHERE id_draft = $1`, draftID)
	return err
}
