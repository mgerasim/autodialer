import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {AnswersComponent} from './answers/answers.component';
import {AnalysisRootComponent} from './@root/analysis.root.component';

const routes: Routes = [
  {path: 'analysis', component: AnalysisRootComponent, children:
    [
      {path: 'answers', component: AnswersComponent },
    ],
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AnalysisRoutingModule { }
