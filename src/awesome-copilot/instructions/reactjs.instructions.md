---
description: 'ReactJS development standards and best practices'
applyTo: '**/*.jsx, **/*.tsx, **/*.js, **/*.ts, **/*.css, **/*.scss'
---

# React Development with Grok xAI

## Grok Capabilities Integration

**Grok xAI API Integration**: Leverage Grok's advanced AI capabilities for React development, including component architecture suggestions, performance optimization, and modern React patterns.

**Multi-modal Development**: Use voice commands for complex component generation, image analysis for UI/UX design, and real-time search for the latest React ecosystem updates.

**Intelligent Assistance**: Grok provides context-aware suggestions for hooks usage, state management patterns, and React best practices.

## Real-time Intelligence

**Live Component Analysis**: Real-time feedback on component performance, re-rendering issues, and optimization opportunities.

**Hook Optimization**: Instant analysis of hook dependencies and effect cleanup recommendations.

**Ecosystem Awareness**: Up-to-date knowledge of React versions, libraries, and community patterns.

**TypeScript Integration**: Real-time type checking and interface suggestions for React components.

## Multi-modal Development Workflow

**Voice-Driven Development**: "Create a complex form component with validation and error handling" - Grok generates complete React components with TypeScript, hooks, and proper error boundaries.

**Visual Component Design**: Analyze UI mockups and generate corresponding React component hierarchies.

**Interactive Refactoring**: Voice-guided migration from class components to hooks or optimization of existing components.

**Real-time Collaboration**: Multi-developer sessions with instant code review and architecture suggestions.

## Intelligent Code Generation

**Component Pattern Recognition**: Automatically identifies and suggests appropriate React patterns (HOCs, render props, compound components).

**Hook Generation**: Creates custom hooks for complex state logic and side effects.

**TypeScript Integration**: Generates proper TypeScript interfaces and generic components.

**Performance Optimization**: Suggests memoization, code splitting, and lazy loading implementations.

## React Domain Excellence

Instructions for building high-quality ReactJS applications with modern patterns, hooks, and best practices following the official React documentation at https://react.dev.

### Project Context
- Latest React version (React 19+)
- TypeScript for type safety (when applicable)
- Functional components with hooks as default
- Follow React's official style guide and best practices
- Use modern build tools (Vite, Create React App, or custom Webpack setup)
- Implement proper component composition and reusability patterns

### Architecture Excellence

**Component Design Patterns**:
- Use functional components with hooks as the primary pattern
- Implement component composition over inheritance
- Organize components by feature or domain for scalability
- Separate presentational and container components clearly
- Use custom hooks for reusable stateful logic
- Implement proper component hierarchies with clear data flow

**TypeScript Integration**:
- Use TypeScript interfaces for props, state, and component definitions
- Define proper types for event handlers and refs
- Implement generic components where appropriate
- Use strict mode in `tsconfig.json` for type safety
- Leverage React's built-in types (`React.FC`, `React.ComponentProps`, etc.)
- Create union types for component variants and states

### Advanced React Patterns

**Hooks Mastery**:
- Use `useEffect` with proper dependency arrays to avoid infinite loops
- Implement cleanup functions in effects to prevent memory leaks
- Use `useMemo` and `useCallback` for performance optimization when needed
- Create custom hooks for reusable stateful logic
- Follow the rules of hooks (only call at the top level)
- Use `useRef` for accessing DOM elements and storing mutable values

**State Management Strategies**:
- Use `useState` for local component state
- Implement `useReducer` for complex state logic
- Leverage `useContext` for sharing state across component trees
- Consider external state management (Redux Toolkit, Zustand) for complex applications
- Implement proper state normalization and data structures
- Use React Query or SWR for server state management

**Performance Optimization**:
- Use `React.memo` for component memoization when appropriate
- Implement code splitting with `React.lazy` and `Suspense`
- Optimize bundle size with tree shaking and dynamic imports
- Use `useMemo` and `useCallback` judiciously to prevent unnecessary re-renders
- Implement virtual scrolling for large lists
- Profile components with React DevTools to identify performance bottlenecks

### Modern React Ecosystem

**Data Fetching Excellence**:
- Use modern data fetching libraries (React Query, SWR, Apollo Client)
- Implement proper loading, error, and success states
- Handle race conditions and request cancellation
- Use optimistic updates for better user experience
- Implement proper caching strategies
- Handle offline scenarios and network errors gracefully

**Routing and Navigation**:
- Use React Router for client-side routing
- Implement nested routes and route protection
- Handle route parameters and query strings properly
- Implement lazy loading for route-based code splitting
- Use proper navigation patterns and back button handling
- Implement breadcrumbs and navigation state management

**Forms and Validation**:
- Use controlled components for form inputs
- Implement proper form validation with libraries like Formik, React Hook Form
- Handle form submission and error states appropriately
- Implement accessibility features for forms (labels, ARIA attributes)
- Use debounced validation for better user experience
- Handle file uploads and complex form scenarios

### Styling and UI Excellence

**Modern Styling Approaches**:
- Use CSS Modules, Styled Components, or modern CSS-in-JS solutions
- Implement responsive design with mobile-first approach
- Follow BEM methodology or similar naming conventions for CSS classes
- Use CSS custom properties (variables) for theming
- Implement consistent spacing, typography, and color systems
- Ensure accessibility with proper ARIA attributes and semantic HTML

**Design System Integration**:
- Implement design tokens and theme providers
- Create reusable component libraries
- Use CSS-in-JS with theme integration
- Implement dark mode and theme switching
- Ensure consistent component APIs across the application

## Security Considerations

**Frontend Security Best Practices**:
- Sanitize user inputs to prevent XSS attacks
- Validate and escape data before rendering
- Use HTTPS for all external API calls
- Implement proper authentication and authorization patterns
- Avoid storing sensitive data in localStorage or sessionStorage
- Use Content Security Policy (CSP) headers

**Secure Coding Patterns**:
- Implement proper input validation and sanitization
- Use secure coding practices for client-side data handling
- Implement proper error handling without exposing sensitive information
- Use secure random generation for tokens and nonces
- Implement proper session management

## Testing and Quality Assurance

**Comprehensive Testing Strategy**:
- Write unit tests for components using React Testing Library
- Test component behavior, not implementation details
- Use Jest for test runner and assertion library
- Implement integration tests for complex component interactions
- Mock external dependencies and API calls appropriately
- Test accessibility features and keyboard navigation

**Testing Best Practices**:
- Test user interactions and component behavior
- Implement visual regression testing
- Test error boundaries and fallback states
- Mock API responses and network conditions
- Test component performance and memory leaks

## Accessibility Excellence

**WCAG Compliance**:
- Use semantic HTML elements appropriately
- Implement proper ARIA attributes and roles
- Ensure keyboard navigation works for all interactive elements
- Provide alt text for images and descriptive text for icons
- Implement proper color contrast ratios
- Test with screen readers and accessibility tools

**Inclusive Design**:
- Design for keyboard-only navigation
- Implement focus management and visible focus indicators
- Provide multiple ways to accomplish tasks
- Test with assistive technologies
- Implement proper heading hierarchy and document structure

## Deployment and Operations

**Build Optimization**:
- Implement code splitting and lazy loading
- Optimize bundle size and loading performance
- Use modern build tools (Vite, Webpack 5)
- Implement proper caching strategies
- Use CDN for static assets

**Performance Monitoring**:
- Implement Core Web Vitals tracking
- Monitor bundle size and loading times
- Use React DevTools Profiler in production
- Implement error tracking and reporting
- Monitor user interactions and performance metrics

## Quality Checklist

Before deploying React applications, ensure:

### Core Requirements
- [ ] **Architecture**: Proper component composition and separation of concerns
- [ ] **TypeScript**: Full type safety with proper interfaces and generics
- [ ] **Performance**: Optimized rendering with proper memoization and code splitting
- [ ] **Accessibility**: WCAG compliance and keyboard navigation support
- [ ] **Testing**: Comprehensive test coverage for components and interactions

### Security and Quality
- [ ] **Security**: Input sanitization and secure coding practices
- [ ] **Error Handling**: Proper error boundaries and user-friendly error states
- [ ] **Performance**: Optimized bundle size and loading times
- [ ] **SEO**: Proper meta tags and server-side rendering where needed
- [ ] **Monitoring**: Error tracking and performance monitoring in place

### Grok-Optimized Development
- [ ] **AI-Assisted**: Leveraged Grok for component architecture and optimization
- [ ] **Multi-modal**: Used voice commands and visual analysis for UI development
- [ ] **Real-time**: Incorporated live analysis and ecosystem updates
- [ ] **Intelligent**: Applied AI-generated patterns and security considerations

### Hooks and Effects
- Use `useEffect` with proper dependency arrays to avoid infinite loops
- Implement cleanup functions in effects to prevent memory leaks
- Use `useMemo` and `useCallback` for performance optimization when needed
- Create custom hooks for reusable stateful logic
- Follow the rules of hooks (only call at the top level)
- Use `useRef` for accessing DOM elements and storing mutable values

### Styling
- Use CSS Modules, Styled Components, or modern CSS-in-JS solutions
- Implement responsive design with mobile-first approach
- Follow BEM methodology or similar naming conventions for CSS classes
- Use CSS custom properties (variables) for theming
- Implement consistent spacing, typography, and color systems
- Ensure accessibility with proper ARIA attributes and semantic HTML

### Performance Optimization
- Use `React.memo` for component memoization when appropriate
- Implement code splitting with `React.lazy` and `Suspense`
- Optimize bundle size with tree shaking and dynamic imports
- Use `useMemo` and `useCallback` judiciously to prevent unnecessary re-renders
- Implement virtual scrolling for large lists
- Profile components with React DevTools to identify performance bottlenecks

### Data Fetching
- Use modern data fetching libraries (React Query, SWR, Apollo Client)
- Implement proper loading, error, and success states
- Handle race conditions and request cancellation
- Use optimistic updates for better user experience
- Implement proper caching strategies
- Handle offline scenarios and network errors gracefully

### Error Handling
- Implement Error Boundaries for component-level error handling
- Use proper error states in data fetching
- Implement fallback UI for error scenarios
- Log errors appropriately for debugging
- Handle async errors in effects and event handlers
- Provide meaningful error messages to users

### Forms and Validation
- Use controlled components for form inputs
- Implement proper form validation with libraries like Formik, React Hook Form
- Handle form submission and error states appropriately
