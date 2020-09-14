import { IsNotEmpty } from 'class-validator'
import { NotePhrase, Note } from './note'

/**
 * Note Api
 */
export class CreateNoteRequest {
  @IsNotEmpty()
  readonly note!: Note
}

export class UpdateNoteRequest {
  @IsNotEmpty()
  readonly note!: Note
}

export class DeleteNoteRequest {
  @IsNotEmpty()
  readonly noteId!: string
}