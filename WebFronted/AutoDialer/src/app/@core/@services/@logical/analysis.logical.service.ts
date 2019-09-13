import {Injectable} from '@angular/core';
import {AnalysisApiService} from '../@api/analysis.api.service';
import {combineLatest, Observable} from 'rxjs';
import {AnalysisAnswersLogicalModel} from '../../@models/@logical/analysis.answers.logical.model';
import {map} from 'rxjs/operators';
import {TrunkApiModel} from '../../@models/@api/trunk.api.model';

@Injectable()
export class AnalysisLogicalService {
  constructor(private analysisApiService: AnalysisApiService) {}

  getAnswers(): Observable<AnalysisAnswersLogicalModel[]> {
    return combineLatest([this.analysisApiService.getAnswers(), this.analysisApiService.getOutgoings(), this.analysisApiService.getTrunks()])
      .pipe(map(([answers, outgoings, trunks]) => {
        if (answers.data !== undefined) {
          answers = answers.data;
        }
        const groupedAnswers = answers.reduce((previous, current) => {
          if(!previous[current['trank_id']]) {
            previous[current['trank_id']] = [current];
          } else {
            previous[current['trank_id']].push(current);
          }
          return previous;
        }, {});

        if (outgoings.data !== undefined) {
          outgoings = outgoings.data;
        }
        const groupedOutgoings = outgoings.reduce((previous, current) => {
          if(!previous[current['trank_id']]) {
            previous[current['trank_id']] = [current];
          } else {
            previous[current['trank_id']].push(current);
          }

          return previous;
        }, {});

        const list = new Array<AnalysisAnswersLogicalModel>();

        trunks.forEach((trunk: TrunkApiModel) => {
          const x = trunk.id.toString();
          const model = new AnalysisAnswersLogicalModel();
          model.trunk = trunk.name;
          model.outgoingCount = groupedOutgoings[x] ===  undefined ? 0 : groupedOutgoings[x].length;
          model.answersCount = groupedAnswers[x] === undefined ? 0 : groupedAnswers[x].length;
          model.callbackCount = groupedAnswers[x] === undefined ? 0 : groupedAnswers[x].filter(a => a.level === 0).length;
          model.agreedCount = groupedAnswers[x] === undefined ? 0 : groupedAnswers[x].filter(a => a.level === 1).length;
          model.confirmedCount = groupedAnswers[x] === undefined ? 0 : groupedAnswers[x].filter(a => a.level === 2).length;

          list.push(model);
        });
        return list;
      }));
  }
}
