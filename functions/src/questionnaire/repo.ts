/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { firestore } from 'firebase-admin'
import { Questionnaire } from './model'

export class QuestionnaireRepository {
  questionnaires: firestore.CollectionReference

  constructor() {
    this.questionnaires = firestore().collection('questionnaires')
  }

  public async add(questionnaire: Questionnaire): Promise<void> {
    await this.questionnaires.add(questionnaire)
  }
}

export const questionnaires = new QuestionnaireRepository()
