import { Component, OnInit } from '@angular/core';
import {environment} from '../../../environments/environment.prod';

@Component({
  selector: 'app-answers',
  templateUrl: './caninet.root.component.html',
  styleUrls: ['./caninet.root.component.css']
})
export class CabinetRootComponent implements OnInit {
  constructor() { }
  ngOnInit() {
  }
  routeLink_Click(link: string) {
    window.location.href = environment.base_url + link;
  }
}
