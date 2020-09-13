/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { UserRepository } from './userRepository'
import { Note, NotePhrase } from './model/note'
import { v4 as uuidv4 } from 'uuid'
import _ from 'lodash'
import * as functions from 'firebase-functions'

export class NoteService {
  private readonly repo: UserRepository

  constructor(repo: UserRepository) {
    this.repo = repo
  }

  static generateNotePhrase(): NotePhrase {
    return {
      schemaVersion: 'v1',
      id: uuidv4(),
      word: '',
      translation: '',
      achieved: false,
    }
  }

  static generateNote(noteId: string, title: string, isDefault: boolean = false): Note {
    // 30 phrases
    return {
      schemaVersion: 'v1',
      id: noteId,
      isDefault: isDefault,
      title: title,
      sortType: 'createdAt-',
      phrases: [...Array(30)].map(_ => NoteService.generateNotePhrase()),
    }
  }

  // ノートを作成
  async createNote(userId: string, title: string): Promise<Note> {
    const user = await this.repo.findById(userId)

    const userNoteLimit = 3 + (user.items['extra_note'] ?? 0)
    const noteCount = Object.keys(user.notes).length
    console.log(`limit: ${userNoteLimit}, notes: ${noteCount}`)
    if (userNoteLimit <= noteCount) {
      throw new functions.https.HttpsError('out-of-range', `note limit exceeded`)
    }

    const noteId = uuidv4()
    const note = NoteService.generateNote(noteId, title)

    user.notes[noteId] = note
    await this.repo.update(user)
    return note
  }

  async updateNoteTitle(userId: string, noteId: string, title: string): Promise<Note> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw new functions.https.HttpsError('not-found', `note ${noteId} not found`)
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
      throw new functions.https.HttpsError('not-found', `note ${noteId} not found`)
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

  async addPhraseInNote(userId: string, noteId: string, phrase: NotePhrase): Promise<Note> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw new functions.https.HttpsError('not-found', `note ${noteId}/ not found`)
    }

    user.notes[noteId].phrases.push(phrase)
    await this.repo.update(user)
    return user.notes[noteId]
  }

  async updatePhraseInNote(userId: string, noteId: string, phraseId: string, phrase: NotePhrase): Promise<Note> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw new functions.https.HttpsError('not-found', `note ${noteId} not found`)
    }

    const index = user.notes[noteId].phrases.findIndex(p => p.id === phraseId)
    if (index === -1) {
      throw new functions.https.HttpsError('not-found', `note ${noteId}/${phraseId} not found`)
    }

    user.notes[noteId].phrases[index] = phrase
    await this.repo.update(user)
    return user.notes[noteId]
  }

  async deletePhraseInNote(userId: string, noteId: string, phraseId: string): Promise<void> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw new functions.https.HttpsError('not-found', `note ${noteId} not found`)
    }

    const index = user.notes[noteId].phrases.findIndex(p => p.id === phraseId)

    if (index === -1) {
      throw new functions.https.HttpsError('not-found', `note ${noteId}/${phraseId} not found`)
    }

    delete user.notes[noteId].phrases[index]
    await this.repo.update(user)
  }

  async achievePhraseInNote(userId: string, noteId: string, phraseId: string, achieve: boolean): Promise<void> {
    const user = await this.repo.findById(userId)

    if (!user.notes[noteId]) {
      throw new functions.https.HttpsError('not-found', `note ${noteId} not found`)
    }

    const index = user.notes[noteId].phrases.findIndex(p => p.id === phraseId)
    if(index === -1) {
      throw new functions.https.HttpsError('not-found', `note ${noteId}/${phraseId} not found`)
    }

    user.notes[noteId].phrases[index].achieved = achieve

    await this.repo.update(user)
  }
}