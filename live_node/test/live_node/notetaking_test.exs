defmodule LiveNode.NotetakingTest do
  use LiveNode.DataCase

  alias LiveNode.Notetaking

  describe "templates" do
    alias LiveNode.Notetaking.Template

    import LiveNode.NotetakingFixtures

    @invalid_attrs %{title: nil}

    test "list_templates/0 returns all templates" do
      template = template_fixture()
      assert Notetaking.list_templates() == [template]
    end

    test "get_template!/1 returns the template with given id" do
      template = template_fixture()
      assert Notetaking.get_template!(template.id) == template
    end

    test "create_template/1 with valid data creates a template" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Template{} = template} = Notetaking.create_template(valid_attrs)
      assert template.title == "some title"
    end

    test "create_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notetaking.create_template(@invalid_attrs)
    end

    test "update_template/2 with valid data updates the template" do
      template = template_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Template{} = template} = Notetaking.update_template(template, update_attrs)
      assert template.title == "some updated title"
    end

    test "update_template/2 with invalid data returns error changeset" do
      template = template_fixture()
      assert {:error, %Ecto.Changeset{}} = Notetaking.update_template(template, @invalid_attrs)
      assert template == Notetaking.get_template!(template.id)
    end

    test "delete_template/1 deletes the template" do
      template = template_fixture()
      assert {:ok, %Template{}} = Notetaking.delete_template(template)
      assert_raise Ecto.NoResultsError, fn -> Notetaking.get_template!(template.id) end
    end

    test "change_template/1 returns a template changeset" do
      template = template_fixture()
      assert %Ecto.Changeset{} = Notetaking.change_template(template)
    end
  end

  describe "notes" do
    alias LiveNode.Notetaking.Note

    import LiveNode.NotetakingFixtures

    @invalid_attrs %{content: nil, title: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Notetaking.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Notetaking.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      valid_attrs = %{content: "some content", title: "some title"}

      assert {:ok, %Note{} = note} = Notetaking.create_note(valid_attrs)
      assert note.content == "some content"
      assert note.title == "some title"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notetaking.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      update_attrs = %{content: "some updated content", title: "some updated title"}

      assert {:ok, %Note{} = note} = Notetaking.update_note(note, update_attrs)
      assert note.content == "some updated content"
      assert note.title == "some updated title"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Notetaking.update_note(note, @invalid_attrs)
      assert note == Notetaking.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Notetaking.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Notetaking.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Notetaking.change_note(note)
    end
  end
end
