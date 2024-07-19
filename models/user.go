package models

import (
	"time"

	"github.com/jackc/pgtype"
)

type UserProfile struct {
	ID           int          `json:"id_user_profile"`
	Login        string       `json:"login"`
	Password     string       `json:"-"`
	RefreshToken string       `json:"-"`
	AccessToken  string       `json:"-"`
	DtReg        time.Time    `json:"dt_reg"`
	Name         string       `json:"name"`
	Surname      string       `json:"surname"`
	Patronymic   string       `json:"patronymic"`
	DtBirth      time.Time    `json:"dt_birth"`
	Email        string       `json:"email"`
	Phone        string       `json:"phone"`
	SnLinks      pgtype.JSONB `json:"sn_links"`
	HrefAvatar   string       `json:"href_avatar"`
	IsActive     bool         `json:"is_active"`
	IsStaff      bool         `json:"is_staff"`
	Skill        pgtype.JSONB `json:"skill"`
}
