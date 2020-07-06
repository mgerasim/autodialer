import {TrunkApiModel} from './trunk.api.model';

export class AnswerApiModel {
  id: number
  level: number;
  trank_id: number;
  contact: number;
  trank: TrunkApiModel;
}
