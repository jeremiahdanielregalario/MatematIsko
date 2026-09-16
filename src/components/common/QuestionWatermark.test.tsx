import { render, screen } from '@testing-library/react';
import { describe, expect, it } from 'vitest';
import { QuestionWatermark } from './QuestionWatermark';
import { WatermarkEmailContext } from './watermarkContext';

describe('QuestionWatermark', () => {
  it('marks only its content and updates to the current authenticated email', () => {
    const view = (email: string | null) => (
      <WatermarkEmailContext.Provider value={email}>
        <h1>Dashboard</h1>
        <QuestionWatermark>
          <p>Question text</p>
        </QuestionWatermark>
      </WatermarkEmailContext.Provider>
    );
    const { rerender } = render(view('student@up.edu.ph'));
    const watermark = screen.getByTestId('question-watermark');
    expect(watermark.parentElement).toContainElement(screen.getByText('Question text'));
    expect(watermark.parentElement).not.toContainElement(screen.getByText('Dashboard'));
    expect(decodeURIComponent(watermark.style.backgroundImage)).toContain('student@up.edu.ph');
    rerender(view('other&student@up.edu.ph'));
    expect(decodeURIComponent(watermark.style.backgroundImage)).toContain(
      'other&amp;student@up.edu.ph',
    );
    expect(screen.queryByText('Personal study copy · student@up.edu.ph')).not.toBeInTheDocument();
    rerender(view(null));
    expect(screen.queryByTestId('question-watermark')).not.toBeInTheDocument();
    expect(screen.getByText('Question text')).toBeInTheDocument();
  });
});
