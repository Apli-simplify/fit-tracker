import { Routes } from '@angular/router';
import { RegisterPageComponent } from './pages/register-page/register-page.component';
import { LoginPageComponent } from './pages/login-page/login-page.component';
import { AddPhotoPageComponent } from './pages/add-photo-page/add-photo-page.component';
import { AddInterestPageComponent } from './pages/add-interest-page/add-interest-page.component';
import { CongratsPageComponent } from './pages/congrats-page/congrats-page.component';
import { GetStartedPageComponent } from './pages/get-started-page/get-started-page.component';

export const routes: Routes = [
    { path: '', component: RegisterPageComponent, title: 'Register Page' },
    { path: 'login', component: LoginPageComponent, title: 'Login Page' },
    { path: 'add-photo', component: AddPhotoPageComponent },
    { path: 'add-interest', component: AddInterestPageComponent },
    { path: 'get-started', component: GetStartedPageComponent },
    { path: 'complete', component: CongratsPageComponent },
    { path: '**', redirectTo: '', pathMatch: 'full' },
];
