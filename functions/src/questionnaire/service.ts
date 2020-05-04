/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { Questionnaire } from './model'
import { questionnaires } from './repo'
import { UserService } from '../user/service'

export class Questionnaireervice {
  static async addQuestionnaire(data: Questionnaire) {
    const user = await UserService.readUser(data.uuid)
    if (!user) {
      throw 'User Not Found'
    }
    return questionnaires.add(data)
  }
}