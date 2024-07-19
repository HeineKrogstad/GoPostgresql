package main

import (
	"GoPostgresql/pkg/database"
	"context"
	"log"
	"strconv"

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

	app.Get("/drafts", func(c *fiber.Ctx) error {
		drafts, err := database.GetDrafts()
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}
		return c.JSON(drafts)
	})

	app.Get("/projects/:projectID/drafts", func(c *fiber.Ctx) error {

		projectIDStr := c.Params("projectID")
		projectID, err := strconv.Atoi(projectIDStr)
		if err != nil {
			return c.Status(400).SendString("Invalid project ID")
		}

		ctx := context.Background()
		drafts, err := database.GetDraftsByProjectID(ctx, projectID)
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}
		return c.JSON(drafts)
	})

	log.Fatal(app.Listen(":3000"))
}
