import {TrunkApiModel} from '../@api/trunk.api.model';

export class AnalysisAnswersLogicalModel {
  /**
   * Транк
   */
  trunk: string;

  /**
   * Количество обработанных номеров
   */
  outgoingCount: number;

  /**
   * Количество откликов
   */
  answersCount: number;

  /**
   * Количество перезвонивших
   */
  callbackCount: number;

  /**
   * Количество согласившихся
   */
  agreedCount: number;

  /**
   * Количество подтвердивших
   */
  confirmedCount: number;
}

