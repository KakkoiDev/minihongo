# Minihongo Content Schema

Relational schema for trilingual content (minihongo, english, japanese).
CSV files validated with [Frictionless Data Framework](https://github.com/frictionlessdata/frictionless-py).

## Tables

### pages

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| name_minihongo | string | required |
| name_english | string | required |
| name_japanese | string | |
| sort_order | integer | required |

Values: vocabulary, grammar, word-building, reading

### categories

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| parent_id | string | FK → categories (nullable) |
| page_id | string | FK → pages, required |
| name_minihongo | string | required |
| name_english | string | required |
| name_japanese | string | |
| sort_order | integer | required |

Hierarchical. parent_id enables nesting (e.g. 第1 > 語順).

### words

181 core vocabulary entries. Renders vocab page table rows.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| category_id | string | FK → categories, required |
| minihongo | string | required |
| english | string | required |
| japanese | string | |
| english_litteral | string | |
| example_minihongo | string | |
| example_english | string | |
| example_japanese | string | |
| sort_order | integer | required |

### grammar

Grammar point components. Pattern name is the minihongo entry.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| category_id | string | FK → categories, required |
| minihongo | string | required |
| english | string | |
| japanese | string | |
| explanation_minihongo | string | |
| explanation_english | string | required |
| explanation_japanese | string | |
| sort_order | integer | required |

### grammar_examples

Example sentences inside grammar-point components.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| grammar_id | string | FK → grammar, required |
| minihongo | string | required |
| english | string | |
| japanese | string | |
| english_litteral | string | |
| sort_order | integer | required |

### compounds

Kanji compound words. Renders word-building compound tables.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| category_id | string | FK → categories, required |
| minihongo | string | required |
| english | string | required |
| japanese | string | |
| english_litteral | string | |
| sort_order | integer | required |

english_litteral holds the parts breakdown (e.g. "大 + 人").

### expressions

181→∞ creative descriptions and common words.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| category_id | string | FK → categories, required |
| minihongo | string | required |
| english | string | required |
| japanese | string | |
| english_litteral | string | |
| sort_order | integer | required |

japanese is populated for common words (生活), empty for 181→∞ descriptions.

### haiku

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| category_id | string | FK → categories, required |
| minihongo | string | required |
| english | string | |
| japanese | string | |
| sort_order | integer | required |

### dialog_groups

Groups dialog lines into a single conversation. Holds the translatable title.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| category_id | string | FK → categories, required |
| title_minihongo | string | required |
| title_english | string | required |
| title_japanese | string | |
| sort_order | integer | required |

### dialogs

Individual dialog lines within a conversation.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| dialog_group_id | string | FK → dialog_groups, required |
| line_number | integer | required |
| speaker_minihongo | string | required |
| speaker_english | string | required |
| speaker_japanese | string | |
| minihongo | string | required |
| english | string | |
| japanese | string | |

### stories

Full story blocks. One row per story.

| Column | Type | Constraints |
|--------|------|-------------|
| id | string | PK |
| category_id | string | FK → categories, required |
| title_minihongo | string | required |
| title_english | string | required |
| title_japanese | string | |
| minihongo | string | required |
| english | string | |
| japanese | string | |
| sort_order | integer | required |

## Relationships

```
pages ←── categories ←──┬── words (181)
               │        ├── grammar (28) ←── grammar_examples (30)
               │        ├── compounds (167)
               │        ├── expressions (938)
               │        ├── haiku (32)
               │        ├── dialog_groups (14) ←── dialogs (117)
               │        └── stories (4)
               │
               └── categories (self-ref via parent_id)
```

## Design decisions

- Every content table has minihongo/english/japanese columns for consistent i18n
- categories is the single shared FK - keeps joins simple
- Dialog speakers are separate columns (translatable: 母 → Mother)
- sort_order everywhere to preserve page rendering order
- No compound parts → words FK. Parts stored as string "大 + 人" to avoid fragility
- Grammar pattern name goes in minihongo column (語順, です/だ, etc.)
- Validation via Frictionless Data: `pip install frictionless && frictionless validate datapackage.json`
- All files are CSV, committed to git. No database server needed
