import { Component, OnInit } from '@angular/core';
import {environment} from '../../../environments/environment.prod';

@Component({
  selector: 'app-answers',
  templateUrl: './analysis.root.component.html',
  styleUrls: ['./analysis.root.component.css']
})
export class AnalysisRootComponent implements OnInit {
  constructor() { }
  ngOnInit() {
  }
  routeLink_Click(link: string) {
    window.location.href = environment.base_url + link;
  }
}
