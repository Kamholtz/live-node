## Context 

mix phx.gen.live Notetaking

## Resources

---
_Represents a markdown note__

Note notes 
fkey_template:id
title:string
date:datetime
text:string 
- [ ] how long?


---
_templates for generating note content (or a note itself)_

Template templates


---
_Blocks that belong to a template. They can be a literal_

TemplateBlock template_blocks
type:string
text:string


---
_tags, as they are definited in obsidian (#abc), will be used for autocomplete_
Tag tags


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
