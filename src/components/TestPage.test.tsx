import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { describe, it, expect, vi, beforeEach } from 'vitest'
import axios from 'axios'
import TestPage from './TestPage'

// Mock axios
vi.mock('axios')
const mockedAxios = vi.mocked(axios)

describe('TestPage', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('renders welcome message and test button', () => {
    render(<TestPage />)
    
    expect(screen.getByText('Welcome to Mall Blog')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Test API' })).toBeInTheDocument()
  })

  it('shows loading state when API is called', async () => {
    mockedAxios.get.mockImplementation(() => new Promise(() => {})) // Never resolves
    
    render(<TestPage />)
    
    const button = screen.getByRole('button', { name: 'Test API' })
    fireEvent.click(button)
    
    expect(screen.getByText('Testing...')).toBeInTheDocument()
    expect(button).toBeDisabled()
  })

  it('displays success response when API call succeeds', async () => {
    const mockResponse = {
      data: {
        message: 'Hello World',
        service: 'mall-server',
        status: 'success',
        timestamp: '2023-01-01T00:00:00Z'
      }
    }
    
    mockedAxios.get.mockResolvedValueOnce(mockResponse)
    
    render(<TestPage />)
    
    const button = screen.getByRole('button', { name: 'Test API' })
    fireEvent.click(button)
    
    await waitFor(() => {
      expect(screen.getByText('Success')).toBeInTheDocument()
      expect(screen.getByText('Hello World')).toBeInTheDocument()
      expect(screen.getByText('mall-server')).toBeInTheDocument()
    })
  })

  it('displays error message when API call fails', async () => {
    mockedAxios.get.mockRejectedValueOnce(new Error('Network Error'))
    
    render(<TestPage />)
    
    const button = screen.getByRole('button', { name: 'Test API' })
    fireEvent.click(button)
    
    await waitFor(() => {
      expect(screen.getByText('Error')).toBeInTheDocument()
      expect(screen.getByText('Network Error')).toBeInTheDocument()
    })
  })
}) 