/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { UserRepository } from './userRepository'
import { Note, NotePhrase } from './model/note'
import { v4 as uuidv4 } from 'uuid'
import _ from 'lodash'
import moment from 'moment'
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
      japanese: '',
      english: '',
      createdAt: moment().toISOString(),
    }
  }

  static generateNote(noteId: string, title: string, isDefaultNote: boolean = false, isAchievedNote: boolean = false): Note {
    return {
      schemaVersion: 'v1',
      id: noteId,
      isDefaultNote: isDefaultNote,
      isAchievedNote: isAchievedNote,
      title: title,
      sortType: 'createdAt-',
      // 30 phrases
      phrases: [...Array(30)].map(_ => NoteService.generateNotePhrase()),
    }
  }

  /**
   * ノートを作成
   * @param userId
   * @param note
   */
  async createNote(userId: string, note: Note): Promise<Note> {
    const user = await this.repo.findById(userId)

    const userNoteLimit = 3 + (user.items['extra_note'] ?? 0)
    const noteCount = Object.keys(user.notes).length
    console.log(`limit: ${userNoteLimit}, notes: ${noteCount}`)
    if (userNoteLimit <= noteCount) {
      throw new functions.https.HttpsError('out-of-range', `note limit exceeded`)
    }

    const noteId = uuidv4()
    user.notes[noteId] = note
    await this.repo.update(user)
    return note
  }

  /**
   * ノートを更新
   * @param userId
   * @param note
   */
  async updateNote(userId: string, note: Note): Promise<Note> {
    const user = await this.repo.findById(userId)
    user.notes[note.id] = note
    await this.repo.update(user)
    return note
  }

  /**
   * ノートを削除
   * @param userId
   * @param noteId
   */
  async deleteNote(userId: string, noteId: string): Promise<void> {
    const user = await this.repo.findById(userId)
    delete user.notes[noteId]
    await this.repo.update(user)
  }
}