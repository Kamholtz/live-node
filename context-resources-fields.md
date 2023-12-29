## Context 

mix phx.gen.live Notetaking

## Resources

---
_Represents a markdown note_

Note notes 
fkey_template:id
title:string
date:datetime
text:string 
- [ ] how long?

The supported types are: array, binary, boolean, date, decimal, enum, float, integer, map, naive_datetime, naive_datetime_usec, references, string, text, time, time_usec, utc_datetime, utc_datetime_usec, uuid
```bash
mix phx.gen.live Notetaking Note notes title:string date_created:date template_id:references:templates content:text
```

---
_templates for generating note content (or a note itself)_

Template templates
title:string

```bash
mix phx.gen.live Notetaking Template templates title:string
```

---
_Blocks that belong to a template. They can be a literal_

TemplateBlock template_blocks
type:string
text:string

```bash
mix phx.gen.live Notetaking TemplateBlock template_blocks type:string text:string
```

---
_tags, as they are definited in obsidian (#abc), will be used for autocomplete_

- Tag tags 

Tag tags name:string


```bash
mix phx.gen.live Notetaking TemplateBlock template_blocks type:string text:string
```

---
_defines the collection of possible or required fields_

NoteClass note_classes 
name:string



---
_fields used in the front matter of notes_

NoteClassField note_class_fields
name:string
type:string


---


## Old idea

---
<!-- TemplateToNoteClass template_to_note_classes -->
