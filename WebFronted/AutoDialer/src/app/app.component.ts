import { Component } from '@angular/core';
import {Router} from '@angular/router';
import {environment} from '../environments/environment.prod';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'AutoDialer';
  constructor(private router: Router) {}

}
