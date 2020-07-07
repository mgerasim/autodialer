import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Observable} from 'rxjs';
import {AnswerApiModel} from '../../@models/@api/answer.api.model';
import {environment} from '../../../../environments/environment';
import {OutgoingApiModel} from '../../@models/@api/outgoing.api.model';
import { TrunkApiModel } from '../../@models/@api/trunk.api.model';

@Injectable()
export class AnalysisApiService {
  public defaultHeaders = new HttpHeaders();
  constructor(private http: HttpClient) { }

  getAnswers(observe?: 'body', reportProgress?: boolean): Observable<AnswerApiModel[]> {
    const headers = this.defaultHeaders;
    return this.http.get<AnswerApiModel[]>(`${environment.base_url}/answers.json`,
      {
        headers,
        observe,
        reportProgress
      }
    );
  }

  getTrunks(observe?: 'body', reportProgress?: boolean): Observable<TrunkApiModel[]> {
    const headers = this.defaultHeaders;
    return this.http.get<TrunkApiModel[]>(`${environment.base_url}/tranks.json`,
      {
        headers,
        observe,
        reportProgress
      }
    );
  }

  getOutgoings(observe?: 'body', reportProgress?: boolean): Observable<OutgoingApiModel[]> {
    const headers = this.defaultHeaders;
    return this.http.get<OutgoingApiModel[]>(`${environment.base_url}/outgoings.json`,
      {
        headers,
        observe,
        reportProgress
      }
    );
  }
}
