package user

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/database"
	"context"
)

func GetAllUsers(ctx context.Context) ([]models.UserProfile, error) {
	query := "SELECT * FROM user_profile"
	rows, err := database.Conn.Query(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []models.UserProfile

	for rows.Next() {
		var user models.UserProfile
		err := rows.Scan(
			&user.ID,
			&user.Login,
			&user.Password,
			&user.RefreshToken,
			&user.AccessToken,
			&user.DtReg,
			&user.Name,
			&user.Surname,
			&user.Patronymic,
			&user.DtBirth,
			&user.Email,
			&user.Phone,
			&user.SnLinks,
			&user.HrefAvatar,
			&user.IsActive,
			&user.IsStaff,
			&user.Skill,
		)
		if err != nil {
			return nil, err
		}
		users = append(users, user)
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	return users, nil
}
