import { Component, OnInit } from '@angular/core';
import {AnalysisLogicalService} from '../../@core/@services/@logical/analysis.logical.service';
import {AnalysisAnswersLogicalModel} from '../../@core/@models/@logical/analysis.answers.logical.model';

@Component({
  selector: 'app-answers',
  templateUrl: './answers.component.html',
  styleUrls: ['./answers.component.css']
})
export class AnswersComponent implements OnInit {

  constructor(private serviceAnalysis: AnalysisLogicalService) { }
  answers: AnalysisAnswersLogicalModel
  ngOnInit() {
    this.serviceAnalysis.getAnswers().subscribe(x => {
      this.answers = x;
    });
  }

}
