package database

import (
	"context"
	"log"

	"github.com/jackc/pgx/v4"
)

var conn *pgx.Conn

func Connect() {
	databaseUrl := "postgres://postgres:1@localhost:5432/postgres"

	var err error
	conn, err = pgx.Connect(context.Background(), databaseUrl)
	if err != nil {
		log.Fatalf("Unable to connect to database: %v\n", err)
	}

	log.Println("Connected to database")
}
