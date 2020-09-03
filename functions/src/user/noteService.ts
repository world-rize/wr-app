/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { UserRepository } from './userRepository'
import { Note } from './model/note'
import { v4 as uuidv4 } from 'uuid'
import { Phrase } from './model/phrase'

export class NoteService {
  private readonly repo: UserRepository

  constructor(repo: UserRepository) {
    this.repo = repo
  }

  static generateNote(noteId: string, title: string, isDefault: boolean = false): Note {
    return {
      schemaVersion: 'v1',
      id: noteId,
      isDefault: true,
      title: title,
      sortType: 'createdAt-',
      phrases: {},
    }
  }

// ノートを作成
// 3つ以上あったら作れない
// 
  async createNote(userId: string, title: string): Promise<Note> {
    const user = await this.repo.findById(userId)
    const noteId = uuidv4()
    const note = NoteService.generateNote(noteId, title)

    user.notes[noteId] = note
    await this.repo.update(user)
    return note
  }

  async updateNoteTitle(userId: string, noteId: string, title: string): Promise<Note> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw `Note ${noteId} not found`
    }

    user.notes[noteId] = {
      title,
      ...user.notes[noteId]
    }
    await this.repo.update(user)
    return user.notes[noteId]
  }

  // 元のdefaultノートのisDefaultをはずす
  async updateDefaultNote(userId: string, noteId: string): Promise<Note> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw `Note ${noteId} not found`
    }

    for (const [_, note] of Object.entries(user.notes)) {
      note.isDefault = false
    }
    user.notes[noteId] = {
      isDefault: true,
      ...user.notes[noteId]
    }
    await this.repo.update(user)
    return user.notes[noteId]
  }

  async deleteNote(userId: string, noteId: string): Promise<void> {
    const user = await this.repo.findById(userId)
    delete user.notes[noteId]
    await this.repo.update(user)
  }

  async addPhraseInNote(userId: string, noteId: string, phrase: Phrase): Promise<Note> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw `Note ${noteId} not found`
    }

    user.notes[noteId].phrases[phrase.id] = phrase
    await this.repo.update(user)
    return user.notes[noteId]
  }

  async updatePhraseInNote(userId: string, noteId: string, phraseId: string, phrase: Phrase): Promise<Note> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw `Note ${noteId} not found`
    }

    if (!user.notes[noteId].phrases[phraseId]) {
      throw `Phrase ${phraseId} not found`
    }

    user.notes[noteId].phrases[phrase.id] = phrase
    await this.repo.update(user)
    return user.notes[noteId]
  }

  async deletePhraseInNote(userId: string, noteId: string, phraseId: string): Promise<void> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw `Note ${noteId} not found`
    }

    delete user.notes[noteId].phrases[phraseId]
    await this.repo.update(user)
  }
}