import {AnswerApiModel} from '../@api/answer.api.model';
import {OutgoingApiModel} from '../@api/outgoing.api.model';

export class AnalysisAnswersLogicalModel {
  answerList: AnswerApiModel[];
  outgoingList: OutgoingApiModel[];
  constructor(answers: AnswerApiModel[], outgoings: OutgoingApiModel[]) {
    this.answerList = answers;
    this.outgoingList = outgoings;
  }
}

