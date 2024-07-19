package main

import (
	"GoPostgresql/pkg/database"
	"GoPostgresql/pkg/draft"
	"GoPostgresql/pkg/node"
	"GoPostgresql/pkg/project"
	"GoPostgresql/pkg/user"
	"context"
	"log"
	"strconv"

	"github.com/gofiber/fiber/v2"
)

func main() {
	database.Connect()

	app := fiber.New()

	app.Get("/projects", func(c *fiber.Ctx) error {
		projects, err := project.GetProjects()
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}
		return c.JSON(projects)
	})

	app.Get("/drafts", func(c *fiber.Ctx) error {
		drafts, err := draft.GetDrafts()
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

		limitStr := c.Query("limit")
		offsetStr := c.Query("offset")

		ctx := context.Background()

		if limitStr != "" && offsetStr != "" {
			limit, err := strconv.Atoi(limitStr)
			if err != nil {
				return c.Status(400).SendString("Invalid limit parameter")
			}

			offset, err := strconv.Atoi(offsetStr)
			if err != nil {
				return c.Status(400).SendString("Invalid offset parameter")
			}

			drafts, err := draft.GetDraftsByProjectIDPagination(ctx, projectID, limit, offset)
			if err != nil {
				return c.Status(500).SendString(err.Error())
			}
			return c.JSON(drafts)
		} else {
			drafts, err := draft.GetDraftsByProjectID(ctx, projectID)
			if err != nil {
				return c.Status(500).SendString(err.Error())
			}
			return c.JSON(drafts)
		}
	})

	app.Get("/users", func(c *fiber.Ctx) error {
		ctx := context.Background()
		users, err := user.GetAllUsers(ctx)
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}
		return c.JSON(users)
	})

	app.Get("/nodes", func(c *fiber.Ctx) error {
		ctx := context.Background()
		nodes, err := node.GetAllNodes(ctx)
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}
		return c.JSON(nodes)
	})

	log.Fatal(app.Listen(":3000"))
}
