import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AnalysisRoutingModule } from './analysis-routing.module';
import { AnswersComponent } from './answers/answers.component';
import {AnalysisApiService} from '../@core/@services/@api/analysis.api.service';
import {HttpClientModule} from '@angular/common/http';
import {GroupByPipe} from '../@core/@pipes/groupBy.pipe';
import {LogPipe} from '../@core/@pipes/log.pipe';
import {AnalysisLogicalService} from '../@core/@services/@logical/analysis.logical.service';
import {DxDataGridModule, DxPieChartModule} from 'devextreme-angular';
import {AnalysisRootComponent} from './@root/analysis.root.component';

@NgModule({
  providers: [
    AnalysisApiService,
    AnalysisLogicalService
  ],
  declarations: [
    AnswersComponent,
    AnalysisRootComponent,
    GroupByPipe,
    LogPipe
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    DxDataGridModule,
    DxPieChartModule,
    AnalysisRoutingModule
  ]
})
export class AnalysisModule { }
