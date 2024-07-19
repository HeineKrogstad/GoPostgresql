package main

import (
	"GoPostgresql/pkg/database"
	"log"

	"github.com/gofiber/fiber/v2"
)

func main() {
	database.Connect()

	app := fiber.New()

	app.Get("/projects", func(c *fiber.Ctx) error {
		projects, err := database.GetProjects()
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}
		return c.JSON(projects)
	})

	log.Fatal(app.Listen(":3000"))
}
