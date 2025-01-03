import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AdminService {
  private apiUrl = 'http://localhost:8080/api';

  constructor(private httpClient: HttpClient) { }

  // Fetch all users
  getAllUsers(): Observable<any> {
    return this.httpClient.get(`${this.apiUrl}/users/all`);
  }

  // Fetch all programs
  getAllPrograms(): Observable<any> {
    return this.httpClient.get(`${this.apiUrl}/programs`);
  }

  // Fetch all exercises
  getAllExercises(): Observable<any> {
    return this.httpClient.get(`${this.apiUrl}/exercises`);
  }

  // Add a new program
  addProgram(programData: {
    name: string;
    time: number;
    image: string;
    exercises: any[];
  }): Observable<any> {
    return this.httpClient.post(`${this.apiUrl}/programs`, programData);
  }

  // Add a new exercise
  addExercise(exerciseData: {
    name: string;
    targetArea: string;
    difficulty: string;
    description: string;
    videoUrl: string;
    duration: number;
  }): Observable<any> {
    return this.httpClient.post(`${this.apiUrl}/exercises`, exerciseData);
  }
}