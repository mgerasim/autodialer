import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Observable} from 'rxjs';
import {Answer} from '../api/models/answer.model.api';
import {environment} from '../../environments/environment';

@Injectable()
export class AnalysisService {
  public defaultHeaders = new HttpHeaders();
  constructor(private http: HttpClient) { }

  getAnswers(observe?: 'body', reportProgress?: boolean): Observable<Answer[]> {
    const headers = this.defaultHeaders;
    return this.http.get<Answer[]>(`${environment.base_url}/answers.json`,
      {
        headers,
        observe,
        reportProgress
      }
    );
  }

}
