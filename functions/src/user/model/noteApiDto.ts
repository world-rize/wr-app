import { IsNotEmpty } from 'class-validator'
import { Phrase } from './phrase'

/**
 * Note Api
 */
export class CreateNoteRequest {
  @IsNotEmpty()
  readonly title!: string
}

export class UpdateNoteTitleRequest {
  @IsNotEmpty()
  readonly noteId!: string

  @IsNotEmpty()
  readonly title!: string
}

export class UpdateDefaultNoteRequest {
  @IsNotEmpty()
  readonly noteId!: string
}

export class DeleteNoteRequest {
  @IsNotEmpty()
  readonly noteId!: string
}

export class AddPhraseInNoteRequest {
  @IsNotEmpty()
  readonly noteId!: string

  @IsNotEmpty()
  readonly phrase!: Phrase
}

export class UpdatePhraseInNoteRequest {
  @IsNotEmpty()
  readonly noteId!: string

  @IsNotEmpty()
  readonly phraseId!: string

  @IsNotEmpty()
  readonly phrase!: Phrase
}

export class DeletePhraseInNote {
  @IsNotEmpty()
  readonly noteId!: string

  @IsNotEmpty()
  readonly phraseId!: string
}