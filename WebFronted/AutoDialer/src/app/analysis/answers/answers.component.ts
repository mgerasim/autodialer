import { Component, OnInit } from '@angular/core';
import {AnalysisService} from '../analysis.service';

@Component({
  selector: 'app-answers',
  templateUrl: './answers.component.html',
  styleUrls: ['./answers.component.css']
})
export class AnswersComponent implements OnInit {

  constructor(private serviceAnalysis: AnalysisService) { }

  ngOnInit() {
    this.serviceAnalysis.getAnswers().subscribe(x => {
      console.log(x);
    });
  }

}
