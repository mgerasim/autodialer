import {Injectable} from '@angular/core';
import {AnalysisApiService} from '../@api/analysis.api.service';
import {combineLatest, Observable} from 'rxjs';
import {AnalysisAnswersLogicalModel} from '../../@models/@logical/analysis.answers.logical.model';
import {map} from 'rxjs/operators';

@Injectable()
export class AnalysisLogicalService {
  constructor(private analysisApiService: AnalysisApiService) {}

  getAnswers(): Observable<AnalysisAnswersLogicalModel> {
    return combineLatest([this.analysisApiService.getAnswers(), this.analysisApiService.getOutgoings()])
      .pipe(map(([answers, outgoings]) => {
        return new AnalysisAnswersLogicalModel(answers, outgoings);
      }));
  }
}
