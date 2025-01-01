import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RegisterAthletePageComponent } from './register-athlete-page.component';

describe('RegisterAthletePageComponent', () => {
  let component: RegisterAthletePageComponent;
  let fixture: ComponentFixture<RegisterAthletePageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RegisterAthletePageComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RegisterAthletePageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
