import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {CabinetLoginComponent} from './login/login.component';
import {WorkSpaceComponent} from './workspace/work-space.component';
import {CabinetRootComponent} from './@root/caninet.root.component';

const routes: Routes = [
  {path: 'cabinet', component: CabinetRootComponent, children:
    [
      {path: 'login', component: CabinetLoginComponent },
      {path: 'workspace', component: WorkSpaceComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CabinetRoutingModule { }
