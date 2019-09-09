import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AnalysisRoutingModule } from './analysis-routing.module';
import { AnswersComponent } from './answers/answers.component';
import {AnalysisService} from './analysis.service';
import {HttpClientModule} from '@angular/common/http';

@NgModule({
  providers: [AnalysisService],
  declarations: [AnswersComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    AnalysisRoutingModule
  ]
})
export class AnalysisModule { }
