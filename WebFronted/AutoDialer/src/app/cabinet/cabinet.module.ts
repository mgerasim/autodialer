import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {CabinetLoginComponent} from './login/login.component';
import {CabinetRoutingModule} from './cabinet-routing.module';
import {WorkSpaceComponent} from './workspace/work-space.component';
import {CabinetRootComponent} from './@root/caninet.root.component';

@NgModule({
  providers: [
  ],
  declarations: [
    CabinetLoginComponent,
    WorkSpaceComponent,
    CabinetRootComponent
  ],
  imports: [
    CommonModule,
    CabinetRoutingModule
  ]
})
export class CabinetModule { }
