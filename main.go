package main

import (
	"GoPostgresql/models"
	"GoPostgresql/pkg/attachment"
	"GoPostgresql/pkg/database"
	"GoPostgresql/pkg/draft"
	"GoPostgresql/pkg/node"
	"GoPostgresql/pkg/project"
	"GoPostgresql/pkg/user"

	"context"
	"log"
	"strconv"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
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
		rubric := c.Query("rubric")

		ctx := context.Background()

		switch {
		case rubric != "" && limitStr != "" && offsetStr != "":
			// По ProjectID & Рубрике + Пагинация
			limit, _ := strconv.Atoi(limitStr)
			offset, _ := strconv.Atoi(offsetStr)
			drafts, err := draft.GetDraftsByProjectAndRubricPagination(ctx, projectID, rubric, limit, offset)
			if err != nil {
				return c.Status(500).SendString(err.Error())
			}
			return c.JSON(drafts)

		case rubric != "":
			// По ProjectID & Рубрике
			drafts, err := draft.GetDraftsByProjectAndRubric(ctx, projectID, rubric)
			if err != nil {
				return c.Status(500).SendString(err.Error())
			}
			return c.JSON(drafts)
		case limitStr != "" && offsetStr != "":
			// По ProjectID + Пагинация
			limit, _ := strconv.Atoi(limitStr)
			offset, _ := strconv.Atoi(offsetStr)
			drafts, err := draft.GetDraftsByProjectIDPagination(ctx, projectID, limit, offset)
			if err != nil {
				return c.Status(500).SendString(err.Error())
			}
			return c.JSON(drafts)
		default:
			// По ProjectID
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

	app.Get("/nodes/:nodeId/draft", func(c *fiber.Ctx) error {
		nodeId, err := c.ParamsInt("nodeId")
		if err != nil {
			return c.Status(400).SendString("Invalid nodeId")
		}

		ctx := context.Background()
		draft, err := draft.GetDraftByNodeID(ctx, nodeId)
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}

		return c.JSON(draft)
	})

	app.Get("/drafts/:draftId/attachments", func(c *fiber.Ctx) error {
		draftID, err := uuid.Parse(c.Params("draftId"))
		if err != nil {
			return c.Status(400).SendString("Invalid draft ID")
		}

		ctx := context.Background()
		attachments, err := attachment.GetAttachmentsByDraftID(ctx, draftID)
		if err != nil {
			return c.Status(500).SendString(err.Error())
		}

		return c.JSON(attachments)
	})

	app.Post("/draft", createDraftHandler)

	app.Delete("/draft/:draftId", deleteDraftHandler)

	log.Fatal(app.Listen(":3000"))
}

func createDraftHandler(c *fiber.Ctx) error {
	var payload struct {
		Node       models.Node       `json:"node"`
		Draft      models.Draft      `json:"draft"`
		Attachment models.Attachment `json:"attachment"`
	}

	if err := c.BodyParser(&payload); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Cannot parse JSON"})
	}

	if payload.Node.Name == "" || payload.Draft.Rubric == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid input"})
	}

	payload.Draft.ID = uuid.New()
	payload.Draft.DtCreate = time.Now()

	if err := draft.CreateDraft(payload.Node, payload.Draft, payload.Attachment); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{"message": "Draft created successfully"})
}

func deleteDraftHandler(c *fiber.Ctx) error {
	draftID, err := uuid.Parse(c.Params("draftId"))
	if err != nil {
		return c.Status(400).SendString("Invalid draft UUID")
	}

	ctx := context.Background()
	err = draft.DeleteDraftByID(ctx, draftID)
	if err != nil {
		return c.Status(500).SendString(err.Error())
	}

	return c.SendStatus(fiber.StatusNoContent)
}
