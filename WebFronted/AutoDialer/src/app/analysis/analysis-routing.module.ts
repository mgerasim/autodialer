import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {AnswersComponent} from './answers/answers.component';

const routes: Routes = [
  {path: 'analysis', component: AnswersComponent, children:
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
